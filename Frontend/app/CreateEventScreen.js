import React, {useState, createRef} from 'react';
import {View, StyleSheet, TextInput, Text, Image, KeyboardAvoidingView, TouchableOpacity, ScrollView} from 'react-native';

import AsyncStorage from '@react-native-async-storage/async-storage';
import {Picker} from '@react-native-picker/picker';
import DateTimePicker from '@react-native-community/datetimepicker';




const CreateEventScreen = ({navigation}) => {
    const [eventName, setEventName] = useState('');
    const [eventImage, setEventImage] = useState('');
    const [eventCategory, setEventCategory] = useState('2');
    const [eventCreated, setEventCreated] = useState(new Date());
    const [eventDate, setEventDate] = useState(new Date());
    const _onDateChange = (e, newDate) => {
        setEventDate(newDate);
    };

    const [eventCapacity, setEventCapacity] = useState('');
    const [eventCity, setEventCity] = useState ('1');
    const [eventAddInfo, setEventAddInfo] = useState('');
    const [eventStatus, setEventStatus] = useState(true);
    const [eventOwner, setEventOwner] = useState('');


    const [successfulRegistration, setSuccessfulRegistration] = useState(false);

    AsyncStorage.getItem('user_id').then((value) =>
        setEventOwner(value)
    );



    const pressCreateEvent = () => {
        console.log("Date: ",eventDate);
        console.log(eventName, eventCategory, eventDate, eventCapacity, eventCity, eventAddInfo); 
        if (!eventName || !eventCategory|| !eventDate || !eventCapacity || !eventCity) {
            alert('Please fill all empty windows.');
            return;
        }

        try{
            const res = fetch('http://192.168.0.102:3000/api/createEvent', {
            method: 'POST',
            mode: 'no-cors',
            headers: {
                'Accept': 'application/json', 
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: eventName,
                image: eventImage,
                category: Number(eventCategory), 
                created_on: eventCreated, 
                date: eventDate, 
                city: Number(eventCity),
                capacity: Number(eventCapacity),
                additional_info: eventAddInfo,
                owner: Number(eventOwner),
                status: eventStatus,
            })
            })

            .then((responseJS) => {
                if (responseJS.status == "200"){
                    setSuccessfulRegistration(true);
                    console.log('Event created successfully!');
                }
                else if (responseJS.status == "404"){
                    alert('Error 404! Try again later.');
                    console.log('Error 404!');
                }
            })
        }catch(error){
            console.log(error)
        }
    }

    if (successfulRegistration == true) {
        return (
            <View style={styles.pageStyle}>
                <Image
                source={require('../assets/register.png')}
                style={styles.successImageStyle}
                />
                <Text style={styles.orTextStyle}>
                    Event Created Successfully!
                </Text>
                <TouchableOpacity
                    style={styles.buttonsStyle}
                    activeOpacity={0.5}
                    onPress={() => navigation.navigate('HomeScreen')}>
                    <Text style={styles.buttonsTextStyle}>
                        Proceed Home
                    </Text>
                </TouchableOpacity>
            </View>
        );
    }



    return (
    <View style={styles.pageStyle}>
        <ScrollView
            keyboardShouldPersistTaps="never"
            contentContainerStyle={{
                justifyContent: 'center',
                alignContent: 'center',
                paddingTop: 60,
                paddingBottom: 120,
            }}>
            
            <KeyboardAvoidingView> 

            <Text style={styles.orTextStyle}>Fill all of the information</Text>

            <Text style={styles.labelStyle}>Select event start date & time</Text>
                <View style={styles.datePickerStyle}>
                    <DateTimePicker 
                        style={{marginRight: 45}}
                        mode={"datetime"}
                        minimumDate={new Date()}
                        timeZoneOffsetInMinutes={0}
                        minuteInterval={10}
                        onChange={_onDateChange}
                        value={eventDate}   
                    />
                </View>

                <View style={styles.typeInSpace}>
                    <TextInput
                        style={styles.typeInTextStyle}
                        onChangeText={(eventName) => setEventName(eventName)}
                        placeholder="Event name"
                        placeholderTextColor="#8b9cb5"
                        autoCapitalize="sentences"
                        returnKeyType="next"
                        onSubmitEditing={() =>
                        fullNameInputRef.current && fullNameInputRef.current.focus()
                        }
                    />
                </View>

                <View style={styles.typeInSpace}>
                    <TextInput
                        style={styles.typeInTextStyle}
                        onChangeText={(eventImage) =>setEventImage(eventImage)}
                        placeholder="Profile image URL"
                        placeholderTextColor="#8b9cb5"
                        returnKeyType="next"
                        keyboardType="url"
                    />
                </View>

                <Text style={styles.labelStyle}>Choose Category</Text>
                <View style={styles.pickerStyle}>
                    <Picker
                        selectedValue={eventCategory}
                        style={{ height: 30, width: 280 }}
                        onValueChange={(itemValue) => setEventCategory(itemValue)}
                    >
                        <Picker.Item label="Party" value="1" />
                        <Picker.Item label="Studying" value="2" />
                        <Picker.Item label="Sports" value="3" />
                    </Picker>
                </View>

                <View style={styles.typeInSpace}>
                    <TextInput
                        style={styles.typeInTextStyle}
                        onChangeText={(eventCapacity) => setEventCapacity(eventCapacity)}
                        placeholder="Event capacity"
                        placeholderTextColor="#8b9cb5"
                        keyboardType="numeric"
                        returnKeyType="next"
                        blurOnSubmit={false}
                    />
                </View>

                <View style={{
                    flexDirection: 'row',
                    height: 100,
                    marginTop: 12,
                    marginLeft: 40,
                    marginRight: 40,
                    marginBottom: 12,}}>
                    <TextInput
                        style={styles.typeInTextStyle}
                        multiline={true}
                        numberOfLines={4}
                        onChangeText={(eventAddInfo) => setEventAddInfo(eventAddInfo)}
                        placeholder="Additional information"
                        placeholderTextColor="#8b9cb5"
                        returnKeyType="next"
                    />
                </View>

                <Text style={styles.labelStyle}>Choose City</Text>
                <View style={styles.pickerStyle}>
                    <Picker
                        selectedValue={eventCity}
                        style={{ height: 50, width: 280,}}
                        onValueChange={(itemValue) => setEventCity(itemValue)}
                    >
                        <Picker.Item label="Trnava" value="2" />
                        <Picker.Item label="Bratislava" value="1" />
                        <Picker.Item label="Nitra" value="3" />
                    </Picker>
                </View>

                <TouchableOpacity
                    style={styles.buttonsStyle}
                    activeOpacity={0.5}
                    onPress={pressCreateEvent}>
                    <Text style={styles.buttonsTextStyle}>CREATE EVENT</Text>
                </TouchableOpacity>

            </KeyboardAvoidingView>
        </ScrollView>
    </View>
    );
};

export default CreateEventScreen;




const styles = StyleSheet.create({
    pageStyle: {
        flex: 1,
        backgroundColor: '#A0FDF7',
        justifyContent: 'center',
        alignContent: 'center',
    },

    successImageStyle: {
        height: 200,
        resizeMode: 'contain',
        marginTop: -100,
        marginBottom: 100,
        marginLeft: -70,
        marginRight: 50,
    },

    successPageTextStyle: {
        flex: 1,
        backgroundColor: '#A0FDF7',
        justifyContent: 'center',
        alignContent: 'center',
    },

    typeInSpace: {
        flexDirection: 'row',
        height: 45,
        marginTop: 12,
        marginLeft: 40,
        marginRight: 40,
        marginBottom: 12,
    },

    typeInTextStyle: {
        flex: 1,
        color: '#74254b',
        paddingLeft: 20,
        paddingRight: 20,
        borderWidth: 2,
        borderRadius: 10,
        borderColor: '#74254b',
    },

    orTextStyle: {
        color: '#74254b',
        fontWeight: 'bold',
        textAlign: 'center',
        fontSize: 24,
        marginBottom: 65,
    },

    buttonsStyle: {
        backgroundColor: '#00DDA7',
        height: 45,
        alignItems: 'center',
        marginLeft: 40,
        marginRight:40,
        marginTop: 50,
        marginBottom: 10,
        borderRadius: 10,
    },

    buttonsTextStyle: {
        color: '#ffffff',
        fontSize: 16,
        fontWeight: 'bold',
        paddingVertical: 12,
    },

    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
    },

    pickerStyle: {
        height: 200,
        width: 295,
        alignItems: 'center',
        borderWidth: 2,
        borderRadius: 10,
        borderColor: '#74254b',
        marginLeft: 40,
        marginRight: 40,
        marginBottom: 12,
    },

    datePickerStyle: {
        flex: 1,
        height: 100,
        width: 295,
        justifyContent: 'space-evenly',
        borderWidth: 2,
        borderRadius: 10,
        borderColor: '#74254b',
        marginLeft: 40,
        marginRight: 40,
        marginBottom: 12,
    },

    labelStyle: {
        color: '#74254b',
        fontSize: 14,
        paddingVertical: 12,
        marginLeft: 60
    }
});