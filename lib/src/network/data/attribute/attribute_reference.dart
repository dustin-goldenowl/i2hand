import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i2hand/src/config/enum/attribute_enum.dart';
import 'package:i2hand/src/network/firebase/base_collection.dart';
import 'package:i2hand/src/network/firebase/collection/collection.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/network/model/common/result.dart';
import 'package:i2hand/src/router/coordinator.dart';
import 'package:i2hand/src/utils/utils.dart';

class AttributeReference extends BaseCollectionReference<MAttribute> {
  AttributeReference()
      : super(
          XCollection.attributes,
          getObjectId: (e) => e.name.getAttributeText(AppCoordinator.context),
          setObjectId: (e, name) =>
              e.copyWith(name: AttributeEnum.getAttributeEnum(name)),
        );

  String getAttributeName(MAttribute attribute) {
    return attribute.name
        .getAttributeText(AppCoordinator.context)
        .toLowerCase();
  }

  Future<MResult<MAttribute>> getOrAddAttribute(MAttribute attribute) async {
    try {
      final result = await get(getAttributeName(attribute));
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MAttribute> result = await set(attribute);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MAttribute>>> getAttributes() async {
    try {
      final QuerySnapshot<MAttribute> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      xLog.e(e);

      return MResult.exception(e);
    }
  }
}
