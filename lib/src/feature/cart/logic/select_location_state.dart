import 'package:equatable/equatable.dart';
import 'package:i2hand/src/network/model/country/location.dart';

enum SelectLocationStatus { init, loading, fail, success }

class SelectLocationState with EquatableMixin {
  SelectLocationState(
      {this.status = SelectLocationStatus.init,
      required this.address,
      this.detailAddress = '',
      this.countryIndex,
      this.stateIndex,
      this.initDetailAddress,
      required this.listCityData,
      required this.listCountryData,
      required this.listStateData,
      this.cityIndex});

  final SelectLocationStatus status;
  final String address;
  final String detailAddress;
  final String? initDetailAddress;
  final int? countryIndex;
  final int? stateIndex;
  final int? cityIndex;
  final List<MLocation> listCountryData;
  final List<MLocation> listStateData;
  final List<MLocation> listCityData;

  SelectLocationState copyWith({
    SelectLocationStatus? status,
    String? address,
    String? detailAddress,
    String? initDetailAddress,
    int? countryIndex,
    int? stateIndex,
    int? cityIndex,
    List<MLocation>? listCountryData,
    List<MLocation>? listStateData,
    List<MLocation>? listCityData,
  }) {
    return SelectLocationState(
      status: status ?? this.status,
      address: address ?? this.address,
      detailAddress: detailAddress ?? this.detailAddress,
      countryIndex: countryIndex ?? this.countryIndex,
      stateIndex: stateIndex ?? this.stateIndex,
      cityIndex: cityIndex ?? this.cityIndex,
      listCityData: listCityData ?? this.listCityData,
      listCountryData: listCountryData ?? this.listCountryData,
      listStateData: listStateData ?? this.listStateData,
      initDetailAddress: initDetailAddress ?? this.initDetailAddress,
    );
  }

  @override
  List<Object?> get props => [
        status,
        address,
        detailAddress,
        countryIndex,
        stateIndex,
        cityIndex,
        listCityData,
        listCountryData,
        listStateData,
        initDetailAddress
      ];
}
