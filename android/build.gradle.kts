plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.untitled25"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.untitled25"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
        ndkVersion = "26.3.11579264"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.22")

    // Firebase dependencies
    implementation("com.google.firebase:firebase-auth:23.0.0")
    implementation("com.google.firebase:firebase-analytics:22.0.0")
    implementation("com.google.android.gms:play-services-auth:21.1.1")
}
