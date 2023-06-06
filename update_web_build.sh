#!/bin/sh

flutter build web --release
cd build/web

git add .
git commit -m "website build update"
git push origin master