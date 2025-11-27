export interface Message {
  role: 'user' | 'model';
  text: string;
  isError?: boolean;
}

export interface ChatLog {
  id: string;
  userId: string;
  role: 'user' | 'model';
  content: string;
  createdAt: string;
}

export interface StatItem {
  label: string;
  value: string;
  icon: string;
}

export interface NavLink {
  label: string;
  href: string;
  isActive?: boolean;
}

export interface AppConfig {
  aiName: string;
  aiPersona: string;
  devName: string;
  apiKeys: string[];
  avatarUrl?: string;
}

export interface UserProfile {
  fullName: string;
  address: string;
  street: string;
  zipCode: string;
  country: string;
  phoneNumber?: string;
}

export interface User {
  id: string;
  username: string;
  accessKey: string;
  role: 'admin' | 'user';
  createdAt: string;
  profile?: UserProfile;
  config?: AppConfig;
}

export interface DatabaseSchema {
  users: User[];
  globalConfig: AppConfig;
}
