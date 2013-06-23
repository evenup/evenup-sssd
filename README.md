What is it?
===========

Puppet module install and configure [sssd](https://fedorahosted.org/sssd/) for LDAP authentication.  SSSD is
intended to replace nss_ldap for authentication.

Usage:
------

Include the SSSD module and it will set up PAM and the nsswitch for local and LDAP auth.

<pre>
  class { 'sssd':
    ldap_base => 'dc=mycompany,dc=com',
    ldap_uri  => 'ldap://ldap1.mycompany.com, ldap://ldap2.mycompany.com',
  }
</pre>


License:
--------
Released under the Apache 2.0 licence

Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
