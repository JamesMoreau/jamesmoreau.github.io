
# Run the flutter project locally.
run:
	flutter run -d chrome
#	flutter run -d chrome --web-renderer canvaskit --release
#	flutter run -d chrome --web-renderer html --release
#	flutter run -d macos

webBuild:
	flutter build web --release

