import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:flutterdapp/Encrypt-Decrypt.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'main.dart' as pass;

class parentModel extends ChangeNotifier {
  bool isLoading = true;
  late Client _httpClient;
  late String _contractAddress;
  late String _abi;
  late Web3Client _client;
// ignore: unused_field
  late Credentials _credentials;
  late String x;
  late String y;
  late String latitude;
  late String longitude;
  late DeployedContract _contract;
  late ContractFunction _readCoordinates;
  Future<void> initiateSetup() async {
    _httpClient = Client();
    _client = Web3Client(
        "https://rinkeby.infura.io/v3/b1c2f7fc53144772a4d6dd43879b2fd7",
        _httpClient);
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    _abi = await rootBundle.loadString("assets/abi.json");
    _contractAddress = "0x0f7eeb87091424388fbF51882bA55D8365582D4f";
//print(_abi);
//print(_contractAddress);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(
        "e3cd24eb42110f5e460bfb03b7fef6c92d8058c7d9f0367bc0eb35f39ec02442");
//print(_credentials);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abi, "GPSTracker"),
        EthereumAddress.fromHex(_contractAddress));
    _readCoordinates = _contract.function("readCoordinates");
    print(_contract);
//print("stopped here");
  }

  getCoordinates() async {
    initiateSetup();
    List readCoordinates = await _client
        .call(contract: _contract, function: _readCoordinates, params: []);
    x = readCoordinates[0];
    y = readCoordinates[1];
    print("data retrieved");
    print(x);
    print(y);
//print(pass.password);
    latitude = EncryptionDecryption.decryptAES(x);
    longitude = EncryptionDecryption.decryptAES(y);
    print("Decrypted");
    print(latitude);
    print(longitude);
    isLoading = false;
    notifyListeners();
  }
}
