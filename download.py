#!/usr/bin/env python
from __future__ import print_function
import os
import sys

def makePackageDir():
   try:
       packages_path = os.path.join(".", "packages")
       os.system("rm -rf {}".format(packages_path))
       os.mkdir(packages_path)
   except:
       pass

def getCacheDir():
   return os.path.join(os.environ["HOME"], ".npm")

def cleanCache():
   print("[+] Clearing local npm cache")
   os.system("rm -rf {}".format(os.path.join(getCacheDir(), "*")))

def installPackage(package):
   if os.path.exists(package):
       with open(package) as f:
           packages = f.read().split("\n")[::-1]
           for p in packages:
               if p != "":
                   print("[+] Installing {}...".format(p))
                   os.system("npm install {}".format(p))
   else:
       print("[+] Installing {}...".format(p))
       os.system("npm install {}".format(package))

def generateProgetPackage():
   print("[+] Copying packages to ./packages")
   for root, dirs, files in os.walk(getCacheDir()):
       for f in files:
           if "package.tgz" == f:
               package_file = os.path.join(root, f)
               dest_file = os.path.join(".","packages", "{}-{}.tgz".format(os.path.basename(os.path.dirname(root)), os.path.basename(root)))
               cmd = "cp {} {}".format(package_file, dest_file)
               os.system(cmd)

if __name__ == "__main__":
   makePackageDir()
   cleanCache()
   installPackage(sys.argv[1])

   if len(sys.argv) == 3 and sys.argv[2] == "dev":
       generateDevPackage()
   else:
       generateProgetPackage()

   cleanCache()

