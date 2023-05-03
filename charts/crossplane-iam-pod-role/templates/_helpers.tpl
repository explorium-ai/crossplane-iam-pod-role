{{- define "roleName" -}}
{{ .Values.role_name_prefix }}-{{ .Values.cluster_name }}-{{ .Values.pod_name }}{{ if .Values.release_suffix }}-{{ .Release.Name }}{{ end }}
{{- end -}}