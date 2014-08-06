use warnings; use strict;

use HTTP::Server::Simple::CGI;

{ package WebServer; use base 'HTTP::Server::Simple::CGI';

use File::Slurp; # import read_file

my $nl = "\x0d\x0a";

sub print_header {

    my $content_type = shift;

    print "HTTP/1.0 200 OK$nl";
    print "Content-Type: $content_type; charset=utf-8$nl$nl";

}

sub serve_file {

    my $path_relative = shift;
    my $content_type  = shift;

    print_header($content_type);

    print read_file($path_relative, binmode => ":raw");

}

sub handle_request {

    my $self = shift;
    my $cgi  = shift;

    my $path = $cgi -> path_info;

#   print STDERR "$path\n";

    if ($path eq '/') {
      serve_file ("index.html", 'text/html');
      return;
    }

    if ($path eq '/jQuery.js') {
      my $jquery_file = '../../jQuery.js';
      if (-e $jquery_file) {
        serve_file ($jquery_file, 'application/javascript');
      }
      else {
        print STDERR "$jquery_file not found\n";
      }
      return;
    }

    if ($path eq '/ajax-delayed') {

      sleep 2;

      print_header('text/plain');

      print "Ajax Answer";
      return;

    }

    if ($path eq '/ajax-json') { # --> datatype_json.html

      print '{"foo": "this", "bar": "that", "baz": "and the other"}';

      return;
    }

    if ($path =~ /\.html$/) {
      serve_file (".$path", 'text/html');
      return;
    }

    if ($path =~ /\.js$/) {
      serve_file (".$path", 'application/javascript');
      return;
    }


#   serve_file( ".$path");
    print STDERR "unhandled path: $path\n";

}

}

# Use Port 8080 (http://localhost:8080)
my $pid = WebServer -> new(8080) -> background;
