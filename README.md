Java _npm_ SemVer
=================

This is a direct port [`node-semver`](https://github.com/npm/node-semver), great to have npm like semantics in a Java application.


Releases
--------

Available in the [Maven Central repository](https://search.maven.org/artifact/com.github.yalinhuang/npm-semver/).

#### Maven configuration

```xml
<dependency>
  <groupId>com.github.yalinhuang</groupId>
  <artifactId>npm-semver</artifactId>
  <version>1.1.2/version>
</dependency>
```

#### Gradle configuration

```groovy
implementation 'com.github.yalinhuang:npm-semver:1.1.2'
```


Quick usage
-----------

```java
Version version = Version.from("1.2.3");
Range range = Range.from("^1.2.0");

range.test(version) // true
```


Full Usage
----------

#### Version comparison

```java
boolean loose = false;

Version v1 = Version.from("1.2.3", loose);
String v2 = Version.from("1.3.0", loose);

v1.compareTo(v2); // -1
v2.compareTo(v1); // +1
v1.compareTo(v1); //  0
```

#### In Range tests

```java
boolean loose = false;

Version v = Version.from("1.2.3", loose);
Range r = Range.from("^1.0.0", loose);

r.test(v); // true
```

#### Range boundaries test

```java
boolean loose = false;

SemVer.isGreaterThenRange("1.3.0", ">1.0.0 <1.4.0", loose); // false
SemVer.isGreaterThenRange("1.5.0", ">1.0.0 <1.4.0", loose); // true
SemVer.isGreaterThenRange("0.9.0", ">1.0.0 <1.4.0", loose); // false

SemVer.isLessThenRange("1.3.0", ">1.0.0 <1.4.0", loose); // false
SemVer.isLessThenRange("1.5.0", ">1.0.0 <1.4.0", loose); // false
SemVer.isLessThenRange("0.9.0", ">1.0.0 <1.4.0", loose); // true
```

#### Sorting

```java
List<Version> versions = new ArrayList<Version>();

versions.add(Version.from("4.2.0", false));
versions.add(Version.from("1.8.0", false));
versions.add(Version.from("1.2.0", false));

versions.sort(new VersionComparator()); // { "4.2.0", "1.8.0", "1.2.0" }
```

#### Versions Stream filtering

```java

List<Version> versions = new ArrayList<Version>();

versions.add(Version.from("4.2.0", false));
versions.add(Version.from("1.8.0", false));
versions.add(Version.from("1.2.0", false));

Range range = Range.from(">3.0.0", false);

version.stream().filter(range::test); // { "4.2.0" }
```


Build and Publishing
--------------------

This project has enabled continuous build on [Travis CI](https://travis-ci.com/yalinhuang/java-npm-semver).
The build script is tracked under `gradle/buildViaTravis.sh` while a release is triggered by GIT tags.

#### Unit testing
```console
$ ./gradlew clean check
```

#### Publish to local repository for integration testing
```console
$ ./gradlew publishToMavenLocal
...

$ tree ~/.m2/repository/com/github/yalinhuang
...
└── npm-semver
    ├── maven-metadata-local.xml
    └── unspecified
        ├── npm-semver-unspecified-javadoc.jar
        ├── npm-semver-unspecified-sources.jar
        ├── npm-semver-unspecified.jar
        ├── npm-semver-unspecified.module
        └── npm-semver-unspecified.pom
```

Or use `pkgVersion` to setup the version:

```
$ ./gradlew -DpkgVersion='0.0.1-dev' publishToMavenLocal
```

License
-------

This library, *java-npm-semver*, is free software ("Licensed Software"); you can
redistribute it and/or modify it under the terms of the [GNU Lesser General
Public License](http://www.gnu.org/licenses/lgpl-2.1.html) as published by the
Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY,
NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General
Public License for more details.

You should have received a copy of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/lgpl-2.1.html) along with this library; if
not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301 USA
