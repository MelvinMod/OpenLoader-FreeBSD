PORTNAME=	openloader
DISTVERSION=	0.29.1
CATEGORIES=	games devel
MASTER_SITES=	LOCAL
DISTNAME=	OpenLoader-${DISTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Mod loader for Space Station 14
LICENSE=	MIT

BUILD_DEPENDS=	dotnet-sdk80>=8.0.0:lang/dotnet-sdk80
RUN_DEPENDS=	${BUILD_DEPENDS}

USES=		zip compiler:c++11-lang
USE_GITHUB=	yes
GH_ACCOUNT=	NLP-Core-Team
GH_PROJECT=	OpenLoader
GH_TAGNAME=	v${DISTVERSION}

WRKDIR=		${WORKDIR}/OpenLoader-main

PLIST_FILES=	bin/SS14.Launcher \
		bin/openloader \
		lib/openloader/bin/loader/SS14.Loader \
		lib/openloader/bin/signing_key

OPTIONS_DEFINE=	DOCS

post-extract:
	${MV} ${WRKDIR} ${WRKDIR}-temp
	${MKDIR} ${WRKDIR}
	${MV} ${WRKDIR}-temp/* ${WRKDIR}

post-patch:
	@${REINPLACE_CMD} -e 's|/home/.*|/usr/local|g' \
		${WRKDIR}/SS14.Launcher/LauncherPaths.cs

do-build:
	@${ECHO_MSG} "Building OpenLoader for FreeBSD..."
	cd ${WRKDIR} && \
		${SETENV} ${MAKE_ENV} dotnet publish SS14.Launcher/SS14.Launcher.csproj \
			/p:FullRelease=True -c Release --no-self-contained -r linux-x64 /nologo /p:RobustILLink=true && \
		${SETENV} ${MAKE_ENV} dotnet publish SS14.Loader/SS14.Loader.csproj \
			-c Release --no-self-contained -r linux-x64 /nologo

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/openloader/bin
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/openloader/bin/loader
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/openloader/Marsey/Mods
	${MKDIR} ${STAGEDIR}${PREFIX}/lib/openloader/Marsey/ResourcePacks

	${INSTALL_PROGRAM} ${WRKDIR}/SS14.Launcher/bin/Release/net10.0/linux-x64/publish/SS14.Launcher \
		${STAGEDIR}${PREFIX}/bin/
	${INSTALL_PROGRAM} ${WRKDIR}/SS14.Loader/bin/Release/net10.0/linux-x64/publish/SS14.Loader \
		${STAGEDIR}${PREFIX}/lib/openloader/bin/loader/

	${INSTALL_DATA} ${WRKDIR}/SS14.Launcher/signing_key \
		${STAGEDIR}${PREFIX}/lib/openloader/bin/

	${LN} -sf ${PREFIX}/bin/SS14.Launcher ${STAGEDIR}${PREFIX}/bin/openloader

.include <bsd.port.mk>
