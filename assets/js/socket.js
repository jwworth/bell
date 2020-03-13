import { Socket } from 'phoenix';
import { v4 as uuidv4 } from 'uuid';

// Declare socket
let socket = new Socket('/socket', { params: { token: window.userToken } });

// Connect to the socket
socket.connect();

// Join channel
let channel = socket.channel('ring:lobby', {});

// Set and get cookie
const userId = uuidv4();
document.cookie = `userID=${userId};samesite=strict`;

const getUserId = document.cookie
  .split('; ')
  .find(row => row.startsWith('userID'))
  .split('=')[1];

// Variables
let bellButton = document.querySelector('#bell-button');
let messagesContainer = document.querySelector('#messages');
let totalRingCountCountainer = document.querySelector('#total-ring-count');
let bellSound = new Audio(
  'https://the-bell.s3.us-east-2.amazonaws.com/Meditation-bell-sound.wav'
);
let progressValue = document.querySelector('#progress-value');
let img = document.querySelector('#bell');

// Handle ringing the bell
bellButton.addEventListener('click', event => {
  // Play sound
  bellSound.play();

  // Notify channel
  channel.push(`increment_ring:${getUserId}`);

  // Show progress bar
  progressValue.classList.add('progress-value');

  // Alter appearance of bell
  img.classList.add('disabled');

  // Disable button
  bellButton.disabled = true;

  // Wait and undo UI changes
  setTimeout(function() {
    // Enable button
    bellButton.disabled = false;

    // Remove changes to appearance of bell
    img.classList.remove('disabled');

    // Wipe out progress bar
    progressValue.classList.remove('progress-value');
  }, 18000);
});

// Handle incoming ring counts from channel
channel.on('ring_counts', payload => {
  // Update current ring count
  let active_count = payload.active_ring_count;
  let message;

  if (active_count === 0) {
    message = 'Nobody is ringing the bell.';
  } else if (active_count === 1) {
    message = '1 person is ringing the bell.';
  } else {
    message = `${active_count} people are ringing the bell.`;
  }

  messagesContainer.innerText = message;

  // Update total ring count copy
  let total_count = payload.total_ring_count;
  totalRingCountCountainer.innerText = `The bell has been rung ${total_count} times.`;
});

// Join the channel
channel
  .join()
  .receive('ok', resp => {
    console.log('Joined successfully', resp);
  })
  .receive('error', resp => {
    console.log('Unable to join', resp);
  });

export default socket;
