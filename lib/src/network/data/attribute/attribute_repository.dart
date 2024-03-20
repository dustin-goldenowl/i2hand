import 'package:i2hand/src/network/model/attribute/attribute_model.dart';
import 'package:i2hand/src/network/model/common/result.dart';

abstract class AttributeRepository {
  Future<MResult<MAttribute>> getOrAddAtribute(MAttribute attribute);
  Future<MResult<List<MAttribute>>> getAttributes();
}
