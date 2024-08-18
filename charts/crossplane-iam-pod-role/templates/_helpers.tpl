{{- define "roleName" -}}
{{- $name := printf "%s%s-%s" .Values.role_name_prefix .Values.cluster_name .Values.pod_name -}}
{{- if .Values.release_suffix }}{{ printf "%s-%s" $name .Release.Name | trunc -63 | trimAll "-" }}{{ else }}{{ $name | trunc -63 | trimAll "-" }}{{ end }}
{{- end -}}
