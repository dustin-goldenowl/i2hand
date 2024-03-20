import 'package:flutter/material.dart';
import 'package:i2hand/src/localization/localization_utils.dart';

enum AttributeEnum {
  status,
  images,
  videos,
  agencyPhone,
  agencyLaptop,
  microProcessor,
  ram,
  hardWare,
  phoneLine,
  hardWareType,
  graphicsCard,
  screenSize,
  warrantyPolicy,
  origin,
  color,
  price;

  String getAttributeText(BuildContext context) {
    switch (this) {
      case AttributeEnum.status:
        return S.of(context).status;
      case AttributeEnum.images:
        return S.of(context).images;
      case AttributeEnum.videos:
        return S.of(context).videos;
      case AttributeEnum.agencyPhone:
        return S.of(context).agencyPhone;
      case AttributeEnum.agencyLaptop:
        return S.of(context).agencyLaptop;
      case AttributeEnum.microProcessor:
        return S.of(context).microProcessor;
      case AttributeEnum.ram:
        return S.of(context).ram;
      case AttributeEnum.phoneLine:
        return S.of(context).phoneLine;
      case AttributeEnum.hardWare:
        return S.of(context).hardWare;
      case AttributeEnum.hardWareType:
        return S.of(context).hardWareType;
      case AttributeEnum.graphicsCard:
        return S.of(context).graphicsCard;
      case AttributeEnum.screenSize:
        return S.of(context).screenSize;
      case AttributeEnum.warrantyPolicy:
        return S.of(context).warrantyPolicy;
      case AttributeEnum.origin:
        return S.of(context).origin;
      case AttributeEnum.price:
        return S.of(context).price;
      case AttributeEnum.color:
        return S.of(context).color;
    }
  }

  static AttributeEnum getAttributeEnum(String attributeText) {
    switch (attributeText) {
      case 'status':
        return AttributeEnum.status;
      case 'images':
        return AttributeEnum.images;
      case 'videos':
        return AttributeEnum.videos;
      case 'agency phone':
        return AttributeEnum.agencyPhone;
      case 'agency laptop':
        return AttributeEnum.agencyLaptop;
      case 'microprocessor':
        return AttributeEnum.microProcessor;
      case 'ram':
        return AttributeEnum.ram;
      case 'phone line':
        return AttributeEnum.phoneLine;
      case 'hardware':
        return AttributeEnum.hardWare;
      case 'hardware type':
        return AttributeEnum.hardWareType;
      case 'graphics card':
        return AttributeEnum.graphicsCard;
      case 'screen size':
        return AttributeEnum.screenSize;
      case 'warranty policy':
        return AttributeEnum.warrantyPolicy;
      case 'origin':
        return AttributeEnum.origin;
      case 'price':
        return AttributeEnum.price;
      case 'color':
        return AttributeEnum.color;
      default:
        return AttributeEnum.status;
    }
  }
}
