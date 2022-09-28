class Response {
  List<Results>? results;

  Response({this.results});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      results!.add(Results.fromJson(json['results'][2]));
    }
  }
}

class Results {
  String? type;
  List<Item>? items;

  Results(
      {this.type,
        this.items});

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    items = <Item>[];
    if(json['item'] != null){
      items!.add(Item.fromJson(json['item']));
    }

    if(json['items'] != null){
      json['items'].forEach((i){
        items!.add(Item.fromJson(i));
      });
    }
  }

  @override
  String toString() {
    return "{\n"
        "\t type: $type\n"
        "\t items: ${items!.length}\n"
        "}";
  }
}

class Item {
  String? nutritionVisibility;
  String? country;
  List<Instructions>? instructions;
  String? keywords;
  String? language;
  int? id;
  int? prepTimeMinutes;
  List<Sections>? sections;
  List<Tags>? tags;

  @override
  String toString() {
    return 'Item{\n'
        '\tnutritionVisibility: $nutritionVisibility,\n'
        '\t country: $country,\n'
        '\t instructions: $instructions,\n'
        '\t keywords: $keywords,\n'
        '\t language: $language,\n'
        '\t id: $id,\n'
        '\t prepTimeMinutes: $prepTimeMinutes,\n'
        '\t sections: $sections,\n'
        '\t tags: $tags,\n'
        '\t nutrition: $nutrition,\n'
        '\t name: $name,\n'
        '\t numServings: $numServings,\n'
        '\t description: $description,\n'
        '\t thumbnailUrl: $thumbnailUrl,\n'
        '\t totalTimeMinutes: $totalTimeMinutes,\n'
        '\t videoUrl: $videoUrl,\n'
        '\t originalVideoUrl: $originalVideoUrl,\n'
        '\t canonicalId: $canonicalId,\n'
        '\t cookTimeMinutes: $cookTimeMinutes,\n'
        '\t promotion: $promotion,\n'
        '\t videoId: $videoId\n'
        '}';
  }

  Nutrition? nutrition;
  String? name;
  int? numServings;
  String? description;
  String? thumbnailUrl;
  int? totalTimeMinutes;
  String? videoUrl;
  String? originalVideoUrl;
  String? canonicalId;
  int? cookTimeMinutes;
  String? promotion;
  int? videoId;

  Item(
      {this.nutritionVisibility,
        this.country,
        this.instructions,
        this.keywords,
        this.language,
        this.id,
        this.prepTimeMinutes,
        this.sections,
        this.tags,
        this.nutrition,
        this.name,
        this.numServings,
        this.description,
        this.thumbnailUrl,
        this.totalTimeMinutes,
        this.videoUrl,
        this.originalVideoUrl,
        this.canonicalId,
        this.cookTimeMinutes,
        this.promotion,
        this.videoId});

  Item.fromJson(Map<String, dynamic> json) {
    nutritionVisibility = json['nutrition_visibility'];
    country = json['country'];
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(Instructions.fromJson(v));
      });
    }
    keywords = json['keywords'];
    language = json['language'];
    id = json['id'];
    prepTimeMinutes = json['prep_time_minutes'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    nutrition = json['nutrition'] != null
        ? Nutrition.fromJson(json['nutrition'])
        : null;
    name = json['name'];
    numServings = json['num_servings'];
    description = json['description'];
    thumbnailUrl = json['thumbnail_url'];
    totalTimeMinutes = json['total_time_minutes'];
    videoUrl = json['video_url'];
    originalVideoUrl = json['original_video_url'];
    canonicalId = json['canonical_id'];
    cookTimeMinutes = json['cook_time_minutes'];
    promotion = json['promotion'];
    videoId = json['video_id'];
  }
}

class Instructions {
  int? startTime;
  String? appliance;
  int? endTime;
  int? temperature;
  int? id;
  int? position;
  String? displayText;

  Instructions(
      {this.startTime,
        this.appliance,
        this.endTime,
        this.temperature,
        this.id,
        this.position,
        this.displayText});

  Instructions.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    appliance = json['appliance'];
    endTime = json['end_time'];
    temperature = json['temperature'];
    id = json['id'];
    position = json['position'];
    displayText = json['display_text'];
  }
}

class Sections {
  List<Components>? components;
  String? name;
  int? position;

  Sections({this.components, this.name, this.position});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(Components.fromJson(v));
      });
    }
    name = json['name'];
    position = json['position'];
  }
}

class Components {
  String? rawText;
  String? extraComment;
  int? id;
  int? position;

  Components(
      {this.rawText,
        this.extraComment,
        this.id,
        this.position});

  Components.fromJson(Map<String, dynamic> json) {
    rawText = json['raw_text'];
    extraComment = json['extra_comment'];
    id = json['id'];
    position = json['position'];
  }
}

class Tags {
  String? name;
  int? id;
  String? displayName;
  String? type;

  Tags({this.name, this.id, this.displayName, this.type});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    displayName = json['display_name'];
    type = json['type'];
  }
}

class Nutrition {
  int? carbohydrates;
  int? fiber;
  String? updatedAt;
  int? protein;
  int? fat;
  int? calories;
  int? sugar;

  Nutrition(
      {this.carbohydrates,
        this.fiber,
        this.updatedAt,
        this.protein,
        this.fat,
        this.calories,
        this.sugar});

  Nutrition.fromJson(Map<String, dynamic> json) {
    carbohydrates = json['carbohydrates'];
    fiber = json['fiber'];
    updatedAt = json['updated_at'];
    protein = json['protein'];
    fat = json['fat'];
    calories = json['calories'];
    sugar = json['sugar'];
  }
}