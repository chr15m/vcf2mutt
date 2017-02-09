#!/usr/bin/env python

from distutils.core import setup

# convert readme to thingy
try:
   import pypandoc
   long_description = pypandoc.convert('README.md', 'rst')
except:
   long_description = ''

setup(name='vcf2mutt',
      version='0.1',
      description='Convert vCard contacts to mutt format aliases.',
      long_description=long_description,
      author='Chris McCormick',
      author_email='chris@mccormick.cx',
      url='http://github.com/chr15m/vcf2mutt',
      packages=['vcf2mutt'],
      package_data = {
          'vcf2mutt' : ['*.hy'],
      },
      #dependency_links=[
      #    'https://github.com/chr15m/...',
      #],
      install_requires=[
          'hy==0.12.1',
          'vobject==0.9.4.1',
          'packaging==16.8',
          'requests==2.13.0',
          'pyasn1==0.2.2',
          'pyOpenSSL==16.2.0',
          #'ndg_httpsclient==0.4.2',
      ],
      scripts=['bin/vcf2mutt']
)

