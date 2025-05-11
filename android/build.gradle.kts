// build.gradle.kts (na raiz do projeto)

plugins {
    id("com.android.application") version "8.2.0" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
