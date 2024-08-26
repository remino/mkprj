mkprj
=====

By Rémino Rem <https://remino.net/>. [ISC License.](LICENSE.txt)

```
mkprj 1.0.1

USAGE: mkprj [<options>] <prjname>

Create a dated project directory.

OPTIONS:

	-d <yyyy-mm-dd>
		Use <date> as the project date. Default is the current date.

	-h
		Show this help screen.

	-p <path>
		Directory containing project directories. Can also be set with PROJECTS_DIR.
		If not set, defaults to the current directory.

	-t <name>
		Use <name> directory template. Can also be a full path.
		Directory of templates must be set in TEMPLATES_DIR.
		If not set, defaults to the current directory.

	-v
		Show script name and version number.

ENVIRONMENT VARIABLES:

	PROJECTS_DIR
		Directory containing project directories. Default is the current directory.
		Current value: .

	TEMPLATES_DIR
		Directory containing project templates. Default is the current directory.
		Current value: .
```
