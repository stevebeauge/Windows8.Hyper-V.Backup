Windows8.Hyper-V.Backup
=======================

A script that performs a backup of a Windows 8 Hyper-V Environment

# Purpose

As a SharePoint developer, I use the Windows 8's Hyper-V feature to virtualize my development environment. I typically have one virtual machine for the domain controller and mail services, one virtual machine for SQL Server, and a bunch of virtual machines for various SharePoint farm (2010, 2013, customer specific, etc).

This is fine, and works great. But I often *break* things when trying new software, Visual Studio plugin or farm configuration.

I **have** to be able to revert back.

From this point, I have two *native* options :

1. Use Hyper-V's SnapShots. I don't like this because:
    * it has a severe performance impact on non-SSD drives.
    * Merges are very slows and requires to shudown the guest OS
    * SnapShots are still located on the same drive that Hyper-V machines. If the disk crashes, the VM are lost.

2. Use native Windows file copy (or tools like robocopy, teracopy, ...)
    * it may works but requires the file not to be locked. In order words, you have to shhudown the guest VM, and wait for the copy to be finished before be able to start again the computer
 
# Solution

The solution used in this script is to rely on Volume Shadow Services. This Windows native service allow to take a snapshot of the hard drive. Then the script copy the Hyper-V files from this snapshot.

Advantages are:
* There's no need to shutdown the guest OS.
* The script clean up the volume shadow service after use
* There's no multiple linked vhd file like Snapshots. Only one vhdx per virtual drive. It's easier to reintegrate into another Hyper-V platform


# TODO

The script currently works, but many improvment can be made, including:

* no hard coded paths
* single Virtual Machine selection
* ...