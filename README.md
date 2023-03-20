# Try it

This should work, but doesn't.

```
$ docker build . --tag phpopt &&
$ docker run --cap-add sys_admin --cap-add sys_ptrace phpopt
```
