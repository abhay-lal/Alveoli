import {configureStore, createSlice,getDefaultMiddleware} from "@reduxjs/toolkit";

const authInitialState = {
    user: {
        _id:"",
        name: "",
        email: "",
        photo: ""
    }
}

const authSlice = createSlice({
    name: 'auth',
    initialState: authInitialState,
    reducers: {
        setData: (state, action) => {
            state.user = action.payload.data
        },
        removeData: (state, action) => {
            state.user = null
            localStorage.removeItem('token')
        },
        updateData: (state, action) => {
            state.user = action.payload.user
            localStorage.removeItem('token')
            localStorage.setItem('token', action.payload.token)
        }
    }
})

export const authAction = authSlice.actions
export default configureStore({
    reducer: authSlice.reducer,
    middleware: (getDefaultMiddleware) => getDefaultMiddleware({serializableCheck: false})
})