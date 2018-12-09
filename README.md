[![Build status](https://ci.appveyor.com/api/projects/status/1dli2nc0p8opclcm?svg=true)](https://ci.appveyor.com/project/mao/psbolts)

PSBolts
=======

![0xHexagram][hexagram]
-----------------------
Everyday utilities wrapped in a Powershell module


Requirements
------------

Windows Powershell 5.0+   
  or   
Windows Powershell Core 6.0+ on all supported platforms incl. Linux and MacOS


Installation
------------

`Install-Module -Name PSBolts`



Usage
-----

- Get list of commands:

  `Get-Command -module PSBolts`  
or  
  `Get-ModuleNounsAndVerbs -module PSBolts`


Advanced topics
---------------

### Build

`./build.ps1`


### CI/CD workflow


#### Commit but do not build at all

1. Commit with ‘[skip ci]’ in the commit message or other skip words (`appveyor.yml -> skip_commits`)
2. Push



#### Commit without publishing to Powershell Gallery

1. Submit PR
   - Create feature branch
   - Commit
   - Push

2. Approve PR

3. Verify build status at Appveyor


#### Publish the new build to Powershell Gallery

1. Submit PR

2. Merge


[hexagram]: https://gist.githubusercontent.com/TurboBasic/9dfd228781a46c7b7076ec56bc40d5ab/raw/03942052ba28c4dc483efcd0ebf4bfc6809ed0d0/hexagram3D.png 'hexagram of Wisdom'
