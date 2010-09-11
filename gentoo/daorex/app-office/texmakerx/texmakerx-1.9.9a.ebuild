# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmakerx/texmakerx-1.99.ebuild,v 1.1 2010/02/25 12:04:42 aballier Exp $

EAPI=1

inherit base versionator qt4

DESCRIPTION="A nice LaTeX-IDE"

# The upstream version numbering is bad, so we have to remove a dot in the
# minor version number
MY_P="${PN}-1.9.9a"

S="${WORKDIR}/${MY_P}"
HOMEPAGE="http://www.xm1math.net/texmakerx/"
SRC_URI="http://www.xm1math.net/texmakerx/${MY_P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE=""

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/qt-gui-4.5.1:4
	>=x11-libs/qt-core-4.5.1:4
	>=app-text/hunspell-1.2.4"

RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-hunspell.patch" )

src_compile() {
	eqmake4 texmakerx.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"

	insinto /usr/share/pixmaps/texmakerx
	doins utilities/texmakerx*.png || die "doins failed."
	doins utilities/texmakerx.svg || die "doins failed."

	dodoc utilities/AUTHORS utilities/CHANGELOG.txt || die "dodoc failed"
}

pkg_postinst() {
	elog "A user manual with many screenshots is available at:"
	elog "/usr/share/${PN}/usermanual_en.html"
	elog
}
