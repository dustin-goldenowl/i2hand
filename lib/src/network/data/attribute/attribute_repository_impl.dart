import 'package:i2hand/src/network/data/attribute/attribute_reference.dart';
import 'package:i2hand/src/network/data/attribute/attribute_repository.dart';
import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/network/model/common/result.dart';

class AttributeRepositoryImpl extends AttributeRepository {
  final attributesRef = AttributeReference();

  @override
  Future<MResult<MAttribute>> getOrAddAtribute(MAttribute attribute) {
    return attributesRef.getOrAddAttribute(attribute);
  }

  @override
  Future<MResult<List<MAttribute>>> getAttributes() {
    return attributesRef.getAttributes();
  }
}
