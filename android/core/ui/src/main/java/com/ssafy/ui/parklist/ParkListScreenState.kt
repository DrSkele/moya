package com.ssafy.ui.parklist

import androidx.compose.runtime.Immutable
import com.ssafy.ui.explorelist.BoxWithImageStateWithData

sealed interface ParkListScreenState {
    @Immutable
    data object Loading : ParkListScreenState
    @Immutable
    data class Loaded(val list: List<BoxWithImageStateWithData>) : ParkListScreenState
    @Immutable
    data class Error(val message: String) : ParkListScreenState
}