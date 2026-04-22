package com.reco.support

import android.app.Application
import com.reco.support.data.AppContainer

class RecoApplication : Application() {
    lateinit var container: AppContainer
        private set

    override fun onCreate() {
        super.onCreate()
        container = AppContainer(this)
    }
}
