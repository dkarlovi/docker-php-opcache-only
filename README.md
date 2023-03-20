# Try it

This seems to work:

```
$ docker build . -t php-opcache-only --load
$ docker run --rm -ti php-opcache-only
```