PostgreSQL IP Address Utility Functions
=======================================

This repository contains some utility functions for working with IPv4 and
IPv6 addresses. These functions supplement and use the PostgreSQL's excellent
set of builtin `inet` functions.

These functions do the following:
* Getting a reverse DNS (.arpa) domain name from an `inet`.
* Conversion to and from array representations of IP addresses.
* Padding and unpadding of IP addresses for lexical comparison.