import java.util.regex.Pattern

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.library") {
        val androidExtension = extensions.findByName("android") ?: return@withId
        val getNamespace = runCatching { androidExtension.javaClass.getMethod("getNamespace") }.getOrNull()
            ?: return@withId
        val currentNamespace = runCatching { getNamespace.invoke(androidExtension) as? String }.getOrNull()
        if (!currentNamespace.isNullOrBlank()) return@withId

        val manifestFile = file("src/main/AndroidManifest.xml")
        if (!manifestFile.exists()) return@withId
        val manifestContent = manifestFile.readText()
        val matcher = Pattern.compile("package\\s*=\\s*\"([^\"]+)\"").matcher(manifestContent)
        if (!matcher.find()) return@withId
        val manifestPackage = matcher.group(1)

        runCatching {
            androidExtension.javaClass.getMethod("setNamespace", String::class.java)
                .invoke(androidExtension, manifestPackage)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
