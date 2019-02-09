# A repository for T-SQL functions

Functions and tests for use on SQL Server 2012 or greater.
Some require SQL Server 2016 or greater

### Text Parsing

Some of these functions are made to be somewhat like regex, without CLR.
However, I've tried to be explicit that they need to be passed safe strings.
I haven't implemented or considered SQL injection problems, so user/untrusted
input shouldn't be passed to these functions at this point.


### Other functions

There are some functions I've kept in a private repostitory, as they are client specific. You may however, see some references to them in comments 
left in the public repository.

