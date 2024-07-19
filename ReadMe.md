# Description

AlmaLinux 9 Docker image of GCC 4.8.5 compiler, used in RHEL 7 and its derivatives (e.g. CentOS 7). It is meant to assist developers porting legacy applications from RHEL / CentOS 7 to newer RHEL 9 -like distributions as Red Hat [does not plan](https://access.redhat.com/solutions/19458) to deliver compatibility compilers for its 9th release.

Patches applied to the code are prepared using the examples and suggestions following:

1. https://stackoverflow.com/questions/41204632/unable-to-build-gcc-due-to-c11-errors
2. https://unix.stackexchange.com/questions/566650/how-do-i-compile-gcc-5-from-source

Prepared as is, no functionality guarantees.
