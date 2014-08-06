## Ajax Requests with jQuery

[synchronous_vs_asynchronous.html](https://github.com/ReneNyffenegger/about-jQuery/blob/master/api/ajax/synchronous_vs_asynchronous.html) can be
used to test the *synchronous* and *asynchronous* behaviour of jQuery. In works in conjunction with
[webserver.pl](https://github.com/ReneNyffenegger/about-jQuery/blob/master/api/ajax/webserver.pl) (a Perl Webserver). This webserver
listens on port 8080 (so the test works on `localhost:8080/synchronous_vs_asynchronous.html`). The request goes to the
url `.../ajax-delayed` which delays the answer be two seconds (`sleep 2` in the webserver).

