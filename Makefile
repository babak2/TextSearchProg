name: C++ CI/CD with Make

on:
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Print Repository Contents
        run: |
          ls -al
          ls -al src
          cat Makefile

      - name: Print Makefile Content
        run: cat Makefile

      - name: Set up GCC
        uses: actions/setup-python@v2
        with:
          python-version: 3.x

      - name: Install GCC
        run: sudo apt-get update && sudo apt-get install -y g++-9

      - name: Check GCC Version
        run: g++ --version

      - name: Print GitHub Workspace
        run: echo "GitHub Workspace: $GITHUB_WORKSPACE"

      - name: Change Directory
        run: cd $GITHUB_WORKSPACE

      - name: Print Current Directory
        run: pwd

      - name: Build
        run: make

      - name: Set up Catch2
        run: git submodule update --init --recursive

      - name: Run Tests
        run: make test

      - name: Display Artifacts
        run: ls -al build

      - name: Deploy (Example)
        if: success()
        run: echo "Deployment step (replace with actual deployment commands)"

      - name: Debug Statement
        if: failure() || cancelled()
        run: echo "The workflow failed or was cancelled."
