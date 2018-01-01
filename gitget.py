#!/usr/bin/python
"""
Modified by Mohammad Afaneh, Afaneh92 - XDA Developers.
Download a specific folder from a github repo:
    ./gitget.py https://github.com/user/project/tree/branch-name/folder
"""
__author__ = 'Divyansh Prakash'

import sys
import subprocess

if __name__ == '__main__':
  if len(sys.argv) > 1:
    github_src = sys.argv[1]

    try:
      head, branch_etc = github_src.split('/tree/')
    except:
      print 'err:\tnot a valid folder url!'
    else:
      print 'fetching...'
      subprocess.call(['svn', 'checkout', '/'.join([head, 'branches/', branch_etc])])
  else:
    print 'use:\tgitget.py https://github.com/user/project/tree/branch-name/folder\n'
