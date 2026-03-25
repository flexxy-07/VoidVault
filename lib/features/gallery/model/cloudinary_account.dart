class CloudinaryAccount {
  final String id;
  final String cloudName;
  final String uploadPreset;
  final String label;
  final int usedStorage; 
  
  CloudinaryAccount({
    required this.id,
    required this.cloudName,
    required this.uploadPreset,
    required this.label,
    required this.usedStorage,
  });

  Map<String, dynamic> toMap() {
    return  {
      'cloudName' : cloudName,
      'uploadPreset' : uploadPreset,
      'label' : label,
      'usedStorage' : usedStorage
    };
  }

  factory CloudinaryAccount.fromMap(String id, Map<String, dynamic> map){
    return CloudinaryAccount(id: id, cloudName: map['cloudName'], uploadPreset: map['uploadPreset'], label: map['label'], usedStorage: map['usedStorage'] ?? 0);
  } 
}

