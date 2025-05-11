// app/build.gradle.kts

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    kotlin("android")
}

android {
    namespace = "com.teuprojeto.mesafacil" // ajusta com o teu package name
    compileSdk = 34

    defaultConfig {
        applicationId = "com.teuprojeto.mesafacil" // igual ao do Firebase
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.10.0")

    // 🔥 Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:33.13.0"))

    // Firebase Analytics (ou outros como auth, firestore, etc)
    implementation("com.google.firebase:firebase-analytics")
}
