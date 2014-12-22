anaconda-rl-fix
===============

This repository contains recipes for building the Python interpreter in a proper way to avoid the auto-completion bug, described in [this bug report](https://github.com/ContinuumIO/anaconda-issues/issues/42).


Prerequisites
-------------

Before you start, make sure that the X11 headers are installed:

    yum install libX11-devel           # on RHEL, CentOS or Fedora
    apt-get install libx11-dev         # on Debian or Ubuntu

and the ncurses headers, if you don't plan to compile the ncurses package:

    yum install ncurses-devel          # on RHEL, CentOS or Fedora
    apt-get install libncursesw5-dev   # on Debian or Ubuntu

Install the conda build package:

    conda install conda-build

Clone the git repository:

    git clone https://github.com/kbg/anaconda-rl-fix.git


Building the python-2.7.9 package
---------------------------------

Build the python-2.7.9_kbg package:

    cd anaconda-rl-fix
    conda build python-2.7.9

Install this package in a new conda environment "mytest":

    conda create -n mytest python=2.7.9_kbg ipython --use-local

Switch to this environment, test the auto-completion in ipython:

    source activate mytest
    ipython
    In [1]: 1.conj<TAB>

You can remove the `mytest` environment again, using:

    source deactivate
    conda remove -n mytest --all

The fixed python package can also be installed in the main environment, but you should be carefull if you plan to do so, as it may break `conda`, if anything goes wrong:

    conda install --use-local python=2.7.9_kbg

If you run into problems during the build, you can also activate some additional debug output by editing the file `meta.yaml` in the `python-2.7.9` directory and replacing `setup-fixdirs.patch` with `setup-fixdirs-with-debug-output.patch` in the `source/patches` section, e.g.:

    source:
      # ...
      patches:
        - setup-fixdirs-with-debug-output.patch

You might also want to write the text output of the build process into a file for later review (`build_python-2.7.9.log` in this example):

    conda build python-2.7.9 2>&1 | tee build_python-2.7.9.log


Building the python-2.7.9_nc package using a custom ncurses build
-----------------------------------------------------------------

Build the `ncurses` package:

    cd anaconda-rl-fix
    conda build ncurses

Build the python-2.7.9_nc_kbg package, which uses the previously built `ncurses` package instead of the system's ncurses library:

    conda build python-2.7.9_nc

Install these packages in a new conda environment "mytest":

    conda create -n mytest python=2.7.9_nc_kbg ipython --use-local


Additional notes
----------------

- The Python-3.4.2 packages can be built in the same way as the Python-2.7.9 packages.
