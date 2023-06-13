
# Run the flutter project locally.
run:
	flutter run -d chrome --web-renderer canvaskit
#	flutter run -d chrome --web-renderer canvaskit --release
#	flutter run -d chrome --web-renderer html --release
#	flutter run -d macos

# Update the github pages repository with the latest web build of the app.
update_server:
	flutter build web --release
	cd build/web

	git add .
	git commit -m "website build update"
	git push origin main