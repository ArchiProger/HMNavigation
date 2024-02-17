$(xcrun --find docc) process-archive \
	transform-for-static-hosting NavigationSheet.doccarchive \
	--output-path ./docs \
	--hosting-base-path HM_navigation
