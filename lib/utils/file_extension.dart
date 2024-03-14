String getFileExtension(String filePath) {
  int dotIndex = filePath.lastIndexOf('.');

  if (dotIndex != -1 && dotIndex < filePath.length - 1) {
    // Ensure the dot is not the last character
    return filePath.substring(dotIndex);
  }

  return ''; // Return empty string if no dot found or it's the last character
}
