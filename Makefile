build:
	pdc src/ ThreeDee.pdx

dev: build
	watchman-make -p 'src/**/*' -t build

release:
	bash hack/release.sh
