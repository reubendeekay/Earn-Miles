
const functions = require("firebase-functions");
const admin = require("firebase-admin");

const parse = require("./parse");

admin.initializeApp();

exports.lmno_callback_url = functions.https.onRequest(async (req, res) => {
    const callbackData = req.body.Body.stkCallback;
    const parsedData = parse(callbackData);

    let uid = req.query.uid.split("/")[0];
   let amount = req.query.uid.split("/")[1];
    
    

    let lmnoResponse = admin.firestore().collection('transactions').doc('deposit').collection(uid).doc('/' + parsedData.checkoutRequestID + '/');
    let transaction = admin.firestore().collection('transactions').doc('deposit').collection(uid).doc('/' + parsedData.checkoutRequestID + '/');
    let wallets = admin.firestore().collection('users');

    if ((await lmnoResponse.get()).exists) {
        await lmnoResponse.update(parsedData);
    } else {
        await lmnoResponse.set(parsedData);
    } 
    if ((await transaction.get()).exists) {
        await transaction.update({
            'amount': amount,
            'confirmed': true
        });
    } else {
        await transaction.set({
            'moneyType': 'money',
            'type': 'deposit',
            'amount': amount,
            'confirmed': true
        });
    }
    let walletId = await transaction.get().then(value => value.data().toUserId);
    let adminWallet = await admin.firestore().collection('admin').doc('mainAccount').get();

    // let wallet = wallets.doc('/' + walletId + '/');
    let wallet = wallets.doc(uid);
    console.log('TYPE OF AMOUNT: ' + typeof parsedData.amount);
    
    if ((typeof parsedData.amount) === number) {
    
   
        if ((await wallet.get()).exists) {
            let balance = await wallet.get().then(value => value.data().balance);
            await wallet.update({
                'balance': parsedData.amount + balance
            })
        } else {
            await wallet.set({
                'balance': parsedData.amount
            })
        }
        let adminBalance = await adminWallet.get().then(value => value.data().balance);
        let depositBalance = await adminWallet.get().then(value => value.data().depositAmount);
        
        await adminWallet.update({
            'balance': adminBalance + parsedData.amount,
            'depositAmount': depositBalance + parsedData.amount,
        })
    }

   

    res.send("Completed");
});



exports.updateBalances = functions.pubsub.schedule('every day 00:00')
  .timeZone('Africa/Nairobi') 
  .onRun(async (context) => {
      console.log('This will be run every after 1 min!');
      let userData =await admin.firestore().collection('users').get();
      userData.forEach(async(user) => {
          let balance = user.data().balance;
          let dailyIncome = user.data().dailyIncome;

          await admin.firestore().collection('users').doc(user.id)
       .update({
              'balance': balance + dailyIncome
          });
      });

      

  return 'Data sent';
});
