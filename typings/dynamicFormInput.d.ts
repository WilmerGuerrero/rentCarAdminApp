export interface DynamicFormInput {
  label: string;
  type: string;
  required: boolean;
  key: string;
  hidden?: boolean;
  values?: { id: number; name: string }[];
}
