
# Run the flutter project locally.
run:
	flutter run -d chrome
#	flutter run -d chrome --web-renderer canvaskit --release
#	flutter run -d chrome --web-renderer html --release
#	flutter run -d macos

# Update the github pages repository with the latest web build of the app.
# "rm -rf github_pages/*" -> Clear the contents of the github_pages directory
# "cp -R build/web/* github_pages/" Copy the web build files to github_pages directory

build:
	flutter build web --release

