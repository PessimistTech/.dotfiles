#!/bin/bash

java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.protocol=true \
	-Dlog.level=ALL \
	-Xms1g \
	-Xmx2G \
	-javaagent:"$HOME/.local/share/lombok/lombok.jar" \
	-Xbootclasspath/a:"$HOME/.local/share/lombok/lombok.jar" \
	-jar "$HOME/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar" \
	-configuration /home/jwilson/.local/share/jdtls/config_linux \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED \
	-data /home/jwilson/workspace

