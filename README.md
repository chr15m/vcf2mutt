Convert vCard contacts to mutt format aliases.

### Install

	pip install vcf2mutt

Hint: `pip install --user vcf2mutt` does not require root and installs to your home directory.

### Use

From a local file:

	vcf2mutt ./contacts.vcf > ~/.aliases

From a remotely hosted contacts file (e.g. from [radicale](http://radicale.org/)):

	vcf2mutt https://USERNAME:PASSWORD@SERVER/.../contacts.vcf/ > ~/.aliases

