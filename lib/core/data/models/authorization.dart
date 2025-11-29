class Authorization {
  List<String>? permissions;
  List<RouteGuard>? routeGuards;

  Authorization({
    this.permissions,
    this.routeGuards,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : null,
      routeGuards: json['route_guards'] != null
          ? (json['route_guards'] as List)
              .map((e) => RouteGuard.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permissions': permissions,
      'route_guards': routeGuards?.map((e) => e.toJson()).toList(),
    };
  }
}

class RouteGuard {
  int? id;
  String? name;
  String? guardName;
  String? description;
  int? isSystem;
  int? isActive;
  int? canDelete;
  int? canEdit;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  RouteGuard({
    this.id,
    this.name,
    this.guardName,
    this.description,
    this.isSystem,
    this.isActive,
    this.canDelete,
    this.canEdit,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory RouteGuard.fromJson(Map<String, dynamic> json) {
    return RouteGuard(
      id: json['id'] as int?,
      name: json['name'] as String?,
      guardName: json['guard_name'] as String?,
      description: json['description'] as String?,
      isSystem: json['is_system'] as int?,
      isActive: json['is_active'] as int?,
      canDelete: json['can_delete'] as int?,
      canEdit: json['can_edit'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'guard_name': guardName,
      'description': description,
      'is_system': isSystem,
      'is_active': isActive,
      'can_delete': canDelete,
      'can_edit': canEdit,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  String? modelType;
  int? modelId;
  int? roleId;

  Pivot({
    this.modelType,
    this.modelId,
    this.roleId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      modelType: json['model_type'] as String?,
      modelId: json['model_id'] as int?,
      roleId: json['role_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model_type': modelType,
      'model_id': modelId,
      'role_id': roleId,
    };
  }
}
