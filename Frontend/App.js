import 'react-native-gesture-handler';

import React from 'react';
import {Button} from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';
import AsyncStorage from '@react-native-async-storage/async-storage';


import LoginScreen from './app/LoginScreen';
import RegisterScreen from './app/RegisterScreen';
import HomeScreen from './app/HomeScreen';
import CreateEventScreen from './app/CreateEventScreen';
import MyEvents from './app/MyEvents';
import MyProfileScreen from './app/MyProfile';
import EventDetail from './app/EventDetail';
import SwipeEvents from './app/SwipeEvents';



const Stack = createStackNavigator();


function App() {
    return (
        <NavigationContainer>
            <Stack.Navigator>
                <Stack.Screen name="LoginScreen" component={LoginScreen}
                options={{headerShown: false}} />
                <Stack.Screen name="RegisterScreen" component={RegisterScreen}
                options={{headerShown: false}} />

                <Stack.Screen name="HomeScreen" component={HomeScreen}
                options={({navigation}) => ({title: 'Home', headerStyle:{backgroundColor: '#00DDA7',}, 
                headerLeft: () => (
                    <Button
                        onPress={() => {
                            navigation.navigate('LoginScreen');
                            AsyncStorage.clear();}}
                            title='Log out'
                            color='#74254b'
                    />
                  ),
                })}/>

                <Stack.Screen name="MyProfileScreen" component={MyProfileScreen}
                options={({navigation}) => ({title: 'My profile', headerStyle:{backgroundColor: '#00DDA7'},         
                headerRight: () => (
                    <Button
                      onPress={() => navigation.navigate('HomeScreen')}
                      title='Home'
                    />
                  ),
                
                })} />

                <Stack.Screen name="CreateEventScreen" component={CreateEventScreen}
                options={{title: 'Create an Event', headerStyle:{backgroundColor: '#00DDA7'}}} />

                <Stack.Screen name="MyEvents" component={MyEvents}
                options={{title: 'My Events', headerStyle:{backgroundColor: '#00DDA7'}}} />

                <Stack.Screen name="EventDetail" component={EventDetail}
                options={({navigation}) => ({title: 'Event Details', headerStyle:{backgroundColor: '#00DDA7'},         
                headerRight: () => (
                    <Button
                      onPress={() => {
                            navigation.navigate('HomeScreen');
                            const removeData = async () => {
                                await AsyncStorage.removeItem('event_id');
                            };
                        }}
                      title='Home'
                    />
                  ),
                
                })} />

                
                <Stack.Screen name="SwipeEvents" component={SwipeEvents}
                options={({navigation}) => ({title: 'Swipe Events', headerStyle:{backgroundColor: '#00DDA7'},         
                headerRight: () => (
                    <Button
                      onPress={() => {
                            navigation.navigate('HomeScreen');
                            const removeData = async () => {
                                await AsyncStorage.removeItem('event_id');
                            };
                        }}
                      title='Home'
                    />
                  ),
                
                })} />


            </Stack.Navigator>
        </NavigationContainer>
    );
};



export default App;