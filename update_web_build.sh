#!/bin/sh

# Use this bash script to github pages repository with the latest web build of the app.

flutter build web --release
cd build/web

git add .
git commit -m "website build update"
git push origin main