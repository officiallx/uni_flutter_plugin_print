import 'package:uni_flutter_plugin/fps/fps_constants.dart';
import 'package:uni_flutter_plugin/utility/extensions.dart';

class TemplateData {
  final List<int> templateData;
  final TemplateType templateType;

  TemplateData({required this.templateData, required this.templateType});

  Map<String, dynamic> toJson() => {
        "template_data": templateData,
        "template_type": templateType.id,
      };
}
