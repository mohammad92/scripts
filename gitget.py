#!/usr/bin/python
"""
Modified by Mohammad Afaneh, Afaneh92 - XDA Developers.
If 'svn' is not installed. You can install it by typing:
    sudo apt install subversion
Download a specific folder from a github repo:
    ./gitget.py https://github.com/user/project/tree/branch-name/folder
"""
__author__ = 'Divyansh Prakash'

import os
import sys
import subprocess

if __name__ == '__main__':
  if len(sys.argv) > 1:
    github_src = sys.argv[1]

    try:
      head, branch_etc = github_src.split('/tree/')
      dir_src = github_src.split('https://github.com/')[1].split('/tree/')[0]
      user = dir_src.split('/')[0]
      project = dir_src.split('/')[1]
      path = project.replace('_', '/')
    except:
      print 'err:\tnot a valid folder url!'
    else:
      print 'fetching...'
      'if not os.path.exists(path): os.makedirs(path)'
      subprocess.call(['svn', 'checkout', '/'.join([head, 'branches/', branch_etc]), '/'.join([path, branch_etc.split('/')[1]])])
  else:
    print 'use:\tgitget.py https://github.com/user/project/tree/branch-name/folder\n'
